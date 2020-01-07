Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70E132B12
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2020 17:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgAGQal (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jan 2020 11:30:41 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:37102 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 11:30:41 -0500
Received: by mail-io1-f48.google.com with SMTP id k24so22886878ioc.4
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6AeteR9HaJuNEin17z9WGBbwByVYusY3EbuYUDXWPo=;
        b=x0Xz9ZUTvj1/jYzjYMsVZIAKZ/mqGb42eMHxkVgGt9KStwD6r24eeEn+6dTfMrJoqf
         eJwGYxfq/NjSqRv1LsPuBCsfXXrwZ3RyWXuR0qVP84hHqE4dRcI0R2LW75+jb6JCrnJY
         90x8eJPGEVcusw8a0nRLtZboam8r/CIjvLs2xausZLp48G46LbqVECx/CQVyRBopHzym
         YfyJroumT9e9u3TBxkOP4TRGh/xGjwYQy4U5dub7iyxPUinrnVJ9kyPFWl47E0mlFQsM
         MXkjOurFAHCj/tVijn6lCu5evmpt7aZHpNZOu8xeUCGiKRrj4IR816JXcx/B/PhFaEZx
         4UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6AeteR9HaJuNEin17z9WGBbwByVYusY3EbuYUDXWPo=;
        b=kz6vh04TmTQFWvtdzoiGc9oLzkGQZCfQrlYbrj9xbkXMmDaMp/3rnKJY+7T2tN282m
         9Gj0kw8HkUU971ncM9b5XhbQIqxD4FTjB1xVv27l4fjWIpnw5JS7PewbsQ6GudvMs3Vk
         s1BVs3iwzG3pQUckN0YM8kdGwm2isSDQCl6w/IeG1+wsfWJT3w90sQ3RnC9k7KzLGm/L
         jXDKEobkWhAB8ZnT5bzQR7HGZxt6dr1UoOxKzedNcP2pP4tL4zzS5U/9dLcIpc3snEnp
         XdhcHSyKUhD6J4XGiMoaepxE/GbcL/br0KtQK4BPgE8pjKubHEbclzUsQxvI5KEqG4vF
         L6Lg==
X-Gm-Message-State: APjAAAWZGfxUL+2FYwG5NEyOelFrvZkUvSZ3Qo53O6WepDEX73KtVBj6
        fWJGZzZB49zl9KBwkhiXOoOYBrLSk1U=
X-Google-Smtp-Source: APXvYqx1ur2mLLh9qeDLu3QHkzypQ2L2R41zNjq3CXIFsur5fVz5DwW1hputK9ZdJDR9soBth72t5A==
X-Received: by 2002:a5d:96d9:: with SMTP id r25mr29398598iol.68.1578414639992;
        Tue, 07 Jan 2020 08:30:39 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w11sm20639ilh.55.2020.01.07.08.30.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:30:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/6] blk-mq: per-ctx tag caching
Date:   Tue,  7 Jan 2020 09:30:31 -0700
Message-Id: <20200107163037.31745-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v2 of this patchset. It should be solid now, the previous version
didn't handle tag flushing correctly, or multiple hardware queue types.

The idea here is that we can reduce the cost of getting a tag for a new
request, if we don't get them piecemeal. Add a per-ctx tag cache, and
grab batches of tags if it's empty. If it's not empty, we can just find
a free bit there.

/sys/kernel/debug/block/<dev>/<hctx>/<cpu>/tag_hit holds some stats
associated with this, so you can check how it's doing.

I've seen nice improvements with this in testing.

-- 
Jens Axboe


