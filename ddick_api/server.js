/* 


실행 전에 express랑 mongodb 까세여

*/


const express = require('express');

const { ObjectId } = require('mongodb');
const { connectDB } = require('./database.js');

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
    res.send('이 사이트는 해커톤을 위한 사이트입니다! :)');
});

app.get('/getDatabase', async (req, res, next) => {
    try {
        const object_id = req.query.oi;
        if (ObjectId.isValid(object_id)) {
            const db = (await connectDB).db("ddick");
            let result = await db.collection('cart').findOne({ _id: new ObjectId(object_id) });
            if (result != null) {
                let deleted = await db.collection('cart').deleteOne({ _id: new ObjectId(object_id) });
                res.status(200).json({ result });
            } else {
                res.status(404).json({ error: '결과 없음' });
            }
        } else {
            res.status(400).json({ error: '접근오류' });
        }
    } catch (err) {
        next(err);
    }
});

app.use((req, res) => {
    res.status(404).json({ error: '요청한 페이지가 없습니다.' });
});

app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).json({ error: '서버 오류' });
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});